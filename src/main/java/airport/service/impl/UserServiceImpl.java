package airport.service.impl;

import airport.dto.UserDTO;
import airport.exception.InvalidRegisterException;
import airport.exception.InvalidUserDataException;
import airport.exception.UserNotFoundException;
import airport.model.AccountType;
import airport.model.Booking;
import airport.model.Flight;
import airport.model.User;
import airport.repository.BookingRepository;
import airport.repository.FlightRepository;
import airport.repository.UserRepository;
import airport.service.UserService;
import airport.util.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

import static airport.util.FileUtil.DEFAULT_AVATAR;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final FlightRepository flightRepository;
    private final BookingRepository bookingRepository;

    public void registerUser(UserDTO dto) {
        log.info("Попытка регистрации нового пользователя с email: {}", dto.getEmail());

        if (userRepository.existsByEmail(dto.getEmail())) {
            log.warn("Ошибка регистрации - email уже используется: {}", dto.getEmail());
            throw new InvalidRegisterException("email", "Email уже используется");
        }

        User user = new User();
        user.setUsername(dto.getUsername());
        user.setEmail(dto.getEmail());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setAccountType(dto.getAccountType() != null ? dto.getAccountType() : AccountType.USER);
        user.setEnabled(dto.getEnabled() != null ? dto.getEnabled() : true);

        User savedUser = userRepository.save(user);
        log.info("Пользователь успешно зарегистрирован с ID: {} и типом: {}", savedUser.getId(), savedUser.getAccountType());
    }

    @Override
    public Optional<UserDTO> findByEmail(String email) {
        log.debug("Поиск пользователя по email: {}", email);
        Optional<UserDTO> result = userRepository.findByEmail(email)
                .map(user -> {
                    UserDTO dto = new UserDTO();
                    dto.setId(user.getId());
                    dto.setUsername(user.getUsername());
                    dto.setEmail(user.getEmail());
                    dto.setEnabled(user.getEnabled());
                    dto.setAccountType(user.getAccountType());
                    return dto;
                });

        if (result.isPresent()) {
            log.debug("Найден пользователь с email: {}", email);
        } else {
            log.debug("Пользователь с email: {} не найден", email);
        }

        return result;
    }

    @Override
    public User findUserByEmail(String email) {
        log.debug("Поиск полной сущности пользователя по email: {}", email);
        User result = userRepository.findByEmail(email).orElse(null);

        return result;
    }

    @Transactional
    @Override
    public void updateUserAvatar(Long userId, MultipartFile file) {
        log.info("Обновление аватара для пользователя ID: {}", userId);
        if (file == null || file.isEmpty()) {
            log.error("Файл для обновления аватара не может быть пустым");
            throw new InvalidUserDataException("Файл не может быть пустым");
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> {
                    log.error("Пользователь с ID {} не найден", userId);
                    return new UserNotFoundException("Пользователь с ID не найден: " + userId);
                });

        try {
            String avatarPath = FileUtil.saveUploadFile(file, FileUtil.IMAGES_SUBDIR);
            log.debug("Аватар сохранен по пути: {}", avatarPath);

            user.setAvatar(avatarPath);
            userRepository.save(user);

            log.info("Аватар пользователя ID {} успешно обновлен", userId);
        } catch (Exception e) {
            log.error("Ошибка при обновлении аватара: {}", e.getMessage());
            throw new InvalidUserDataException("Ошибка при обновлении аватара: " + e.getMessage());
        }
    }

    @Override
    public ResponseEntity<?> getAvatarByUserId(Long userId) {
        String avatarPath = userRepository.findById(userId)
                .map(User::getAvatar)
                .orElse(DEFAULT_AVATAR);
        return FileUtil.getOutputFile(avatarPath, MediaType.IMAGE_JPEG);
    }

    @Override
    public Page<UserDTO> getAllUsersByAccountType(AccountType accountType, Pageable pageable) {
        Page<User> usersPage = userRepository.findByAccountType(accountType, pageable);
        return usersPage.map(this::convertToDto);
    }

    private UserDTO convertToDto(User user) {
        return UserDTO.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .avatar(user.getAvatar())
                .enabled(user.getEnabled())
                .accountType(user.getAccountType())
                .build();
    }


    @Transactional
    @Override
    public void toggleUserStatus(Long userId) {
        log.info("Изменение статуса пользователя ID: {}", userId);

        User user = userRepository.findById(userId)
                .orElseThrow(() -> {
                    log.error("Пользователь с ID {} не найден", userId);
                    return new UserNotFoundException("Пользователь с ID не найден: " + userId);
                });

        if (user.getEnabled()) {
            Page<Flight> airlineFlights = flightRepository.findFlightsByAirlineId(userId, Pageable.unpaged());
            for (Flight flight : airlineFlights) {
                List<Booking> bookings = bookingRepository.findByFlightId(flight.getId());
                if (!bookings.isEmpty()) {
                    log.error("Нельзя заблокировать авиакомпанию с ID {}, так как у нее есть активные брони", userId);
                    throw new IllegalStateException("Нельзя заблокировать авиакомпанию, так как у нее есть активные брони");
                }
            }
        }

        user.setEnabled(!user.getEnabled());
        userRepository.save(user);

        log.info("Статус пользователя ID {} изменен на: {}", userId, user.getEnabled());
    }
}