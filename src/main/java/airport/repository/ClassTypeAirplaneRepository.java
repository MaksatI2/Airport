package airport.repository;

import airport.model.ClassTypeAirplane;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ClassTypeAirplaneRepository extends JpaRepository<ClassTypeAirplane, Long> {
    Optional<ClassTypeAirplane> findByName(String name);
}