package airport.model;


import airport.converter.AccountTypeConverter;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Entity
@Table(name = "users")
@Getter
@Setter
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_name", length = 100)
    private String username;

    @Column(length = 100, unique = true)
    private String email;

    @Column(length = 255)
    private String avatar;

    @Column(length = 100)
    private String password;

    @Column(nullable = false)
    private Boolean enabled = true;

    @Convert(converter = AccountTypeConverter.class)
    @Column(name = "account_type", nullable = false)
    private AccountType accountType;
    }