package airport.repository;

import airport.model.Airplane;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AirplaneRepository extends JpaRepository<Airplane, Long> {

    @Query("SELECT a FROM Airplane a WHERE a.id NOT IN " +
           "(SELECT DISTINCT f.airplane.id FROM Flight f WHERE f.airplane IS NOT NULL)")
    List<Airplane> findAvailableAirplanes();

}