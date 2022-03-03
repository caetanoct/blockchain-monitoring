pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Decentralized Monitoring
 * @dev Monitoring a datacenter in the blockchain
 */
contract decentralized_monitoring {
    // DIF FROM PD2
    bool energy_availability;
    uint256 temperature;
    uint256 air_humidity;
    
    function set_energy_availability(bool energy) public {
        this.energy_availability = energy;
    }

    function retrieve_energy_availability() public view returns (bool){
        return this.energy_availability;
    }
    
}
