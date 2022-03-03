pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Decentralized Monitoring
 * @dev Monitoring a datacenter in the blockchain
 */
contract decentralized_monitoring {
    address public owner;
    // DIF FROM PD2
    bool energy_availability;
    uint256 temperature;
    uint256 air_humidity;
    // default value is the first
    enum Thermostat_mode {off, on, heating, cooling}
    struct Thermostat {
        // dif from pd2
        bool installed;
        Thermostat_mode mode;
        uint256 target_temperature;
    }
    Thermostat thermostat;
    constructor() public {
        // the person who deploys the contract will be the owner
        owner = msg.sender;
        // make thermostat installed flag equals to false
        thermostat.installed = false;
    }

    modifier owner_exclusive() {
      require(
         msg.sender == owner,
         "You are not the owner! you can't use set environment variables."
      );
      _; 
   }
    function get_owner() public view returns (address){
        return owner;
    }

    function set_energy_availability(bool energy) public owner_exclusive {
        energy_availability = energy;
    }

    function retrieve_energy_availability() public view returns (bool){
        return energy_availability;
    }
    
    function set_temperature(uint256 temp) public owner_exclusive {
        temperature = temp;
    }

    function retrieve_temperature() public view returns (uint256){
        return temperature;
    }

    function set_air_humidity(uint256 hum) public owner_exclusive {
        air_humidity = hum;
    }

    function retrieve_air_humidity() public view returns (uint256){
        return air_humidity;
    }

    function install_thermostat() public owner_exclusive {
        thermostat.installed = true;
        thermostat.target_temperature = 18;
    }

    function start_thermostat() public owner_exclusive {
        // ac is ready to use
        if (thermostat.installed) {
            thermostat.mode = Thermostat_mode.on;
        }
    }

    // overwrite target temperature logic
    function set_thermostat_mode(Thermostat_mode mode) public owner_exclusive {
        if (thermostat.installed) {
            thermostat.mode = mode;
        }
    }

    function set_thermostat_target_temperature(uint256 temp) public owner_exclusive {
        if (thermostat.installed) {
            if (thermostat.target_temperature > temp) {
                thermostat.target_temperature = temp;
                // set mode to cooling
                thermostat.mode = Thermostat_mode.cooling;
            } else {
                thermostat.target_temperature = temp;
                // set mode to heating
                thermostat.mode = Thermostat_mode.heating;
            }
        }
    }

    function get_thermostat_mode() public view returns (Thermostat_mode){
        return thermostat.mode;
    }

    function get_thermostat_target_temperatore() public view returns (uint256){
        return thermostat.target_temperature;
    }

    function is_thermostat_installed() public view returns (bool){
        return thermostat.installed;
    }
}
