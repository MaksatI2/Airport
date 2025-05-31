package airport.model;

import lombok.Getter;

@Getter
public enum AccountType {
    USER("USER", 1),
    ADMIN("ADMIN", 2),
    AIRLINE("AIRLINE", 3);

    private final String name;
    private final Integer id;

    AccountType(String name, Integer id) {
        this.name = name;
        this.id = id;
    }

    public static AccountType getById(Integer id) {
        for (AccountType type : values()) {
            if (type.id.equals(id)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Нет AccountType с ID " + id);
    }

    @Override
    public String toString() {
        return name;
    }
}
