package airport.converter;

import airport.model.AccountType;
import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class AccountTypeConverter implements AttributeConverter<AccountType, Integer> {

    @Override
    public Integer convertToDatabaseColumn(AccountType accountType) {
        if (accountType == null) {
            return null;
        }
        return accountType.getId();
    }

    @Override
    public AccountType convertToEntityAttribute(Integer id) {
        if (id == null) {
            return null;
        }
        return AccountType.getById(id);
    }
}
