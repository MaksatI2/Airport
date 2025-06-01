package airport.service;

import airport.dto.UserDTO;
import airport.model.AccountType;
import airport.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

public interface UserService {
    void registerUser(UserDTO dto);
    Optional<UserDTO> findByEmail(String email);
    User findUserByEmail(String email);
    void updateUserAvatar(Long userId, MultipartFile file);
    ResponseEntity<?> getAvatarByUserId(Long userId);
    Page<UserDTO> getAllUsersByAccountType(AccountType accountType, Pageable pageable);
    void toggleUserStatus(Long userId);

    boolean isAdmin(String username);
}