package com.example.demo.Model.serviceImp;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.FuelStock;
import com.example.demo.Model.repository.FuelStockRepository;
import com.example.demo.Model.serviceDesign.FuelService;

@Service
public class FuelServiceImpl implements FuelService {

    @Autowired
    private FuelStockRepository fuelStockRepository;

    @Override
    public FuelStock addFuelStock(FuelStock fuelStock) {

        fuelStock.setLastUpdated(LocalDateTime.now());

        fuelStock.setStatus(
                checkFuelStatus(fuelStock.getAvailableLiters()));

        return fuelStockRepository.save(fuelStock);
    }

    @Override
    public FuelStock updateFuelStock(int stockId,
                                     FuelStock fuelStock) {

        FuelStock existing =
                fuelStockRepository.findById(stockId)
                .orElseThrow(() ->
                        new RuntimeException("Stock Not Found"));

        existing.setAvailableliters(
                fuelStock.getAvailableLiters());

        existing.setDensity(fuelStock.getDensity());

        existing.setLastUpdated(LocalDateTime.now());

        existing.setStatus(
                checkFuelStatus(existing.getAvailableLiters()));

        return fuelStockRepository.save(existing);
    }

    @Override
    public FuelStock getFuelStockByBranch(int branchId) {

        return fuelStockRepository.findByBranchId(branchId);
    }

    @Override
    public List<FuelStock> getAllFuelStocks() {

        return fuelStockRepository.findAll();
    }

    @Override
    public String checkFuelStatus(double liters) {

        if(liters < 1000) {
            return "OUT OF STOCK";
        }
        else if(liters < 5000) {
            return "LOW";
        }

        return "AVAILABLE";
    }
}