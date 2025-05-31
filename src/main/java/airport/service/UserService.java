package airport.service;

import airport.dto.UserDTO;
import airport.model.AccountType;
import airport.model.User;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

public interface UserService {
    void registerUser(UserDTO dto);
    Optional<UserDTO> findByEmail(String email);
    User findUserByEmail(String email);
    void updateUserAvatar(Long userId, MultipartFile file);
    ResponseEntity<?> getAvatarByUserId(Long userId);
    List<UserDTO> getAllUsersByAccountType(AccountType accountType);
    void toggleUserStatus(Long userId);
}