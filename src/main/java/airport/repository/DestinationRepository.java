package airport.repository;

import airport.model.Destination;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface DestinationRepository extends JpaRepository<Destination, Long> {
    List<Destination> findAllByOrderByNameAsc();
    List<Destination> findByNameContainingIgnoreCaseOrderByNameAsc(String name);

    @Query("SELECT d FROM Destination d WHERE LOWER(d.name) LIKE LOWER(CONCAT(:prefix, '%')) ORDER BY d.name ASC")
    List<Destination> findByNameStartingWithIgnoreCase(@Param("prefix") String prefix);
}