package airport.service.impl;

import airport.model.Airplane;
import airport.repository.AirplaneRepository;
import airport.service.AirplaneService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AirplaneServiceImpl implements AirplaneService {

    private final AirplaneRepository airplaneRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Airplane> getAvailableAirplanes() {
        return airplaneRepository.findAvailableAirplanes();
    }


    @Override
    public Airplane getAirplaneById(Long id) {
        return airplaneRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Самолет с ID " + id + " не найден"));
    }
}