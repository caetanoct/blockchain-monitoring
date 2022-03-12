pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Decentralized Monitoring
 * @dev Monitoring a datacenter in the blockchain
 */
contract decentralized_monitoring {
    // contract owner adddress
    address public owner;
    // DIF FROM PD2
    // energy availibity indicator
    bool energy_availability;
    // ambient temperature
    uint256 temperature;
    // ambient air humidity
    uint256 air_humidity;
    // default value is the first, all ac operating modes
    enum Thermostat_mode {off, on, heating, cooling}
    // the thermostat structure
    struct Thermostat {
        // dif from pd2
        bool installed;
        Thermostat_mode mode;
        uint256 target_temperature;
    }
    // our ambient thermostat
    Thermostat thermostat;
    // contract constructor, called on deploy
    constructor() public {
        // the person who deploys the contract will be the owner
        owner = msg.sender;
        // make thermostat installed flag equals to false
        thermostat.installed = false;
    }
    // owner exclusive modifier
    modifier owner_exclusive() {
        require(
            msg.sender == owner,
            "You are not the owner! you can't use set environment variables."
        );
        _; 
    }
    // retrieves contract owner
    function get_owner() public view returns (address){
        return owner;
    }
    // change if electricity is available or not
    function set_energy_availability(bool energy) public owner_exclusive {
        energy_availability = energy;
    }
    // retrieves electricity status
    function retrieve_energy_availability() public view returns (bool){
        return energy_availability;
    }
    // change ambient temperature value
    function set_temperature(uint256 temp) public owner_exclusive {
        temperature = temp;
    }
    // retrieves current temperature value
    function retrieve_temperature() public view returns (uint256){
        return temperature;
    }
    // changes air humidity value
    function set_air_humidity(uint256 hum) public owner_exclusive {
        air_humidity = hum;
    }
    // retrieves current ambient air humidity
    function retrieve_air_humidity() public view returns (uint256){
        return air_humidity;
    }
    // set installed flag and set the target temperature (meaning it is ready to start/change mode and set temperature)
    function install_thermostat() public owner_exclusive {
        thermostat.installed = true;
        thermostat.target_temperature = 18;
    }
    // set thermostat to on if it is installed (ready to use).
    function start_thermostat() public owner_exclusive {
        // ac is ready to use
        if (thermostat.installed) {
            thermostat.mode = Thermostat_mode.on;
        }
    }

    // overwrite target temperature logic, if thermostat is ready then change mode
    function set_thermostat_mode(Thermostat_mode mode) public owner_exclusive {
        if (thermostat.installed) {
            thermostat.mode = mode;
        }
    }
    // set temperature if themostat is installed, and also sets if it will heat or cool depending on the current target temperature
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
    // retrieves thermostat operating mode
    function get_thermostat_mode() public view returns (Thermostat_mode){
        return thermostat.mode;
    }
    // retrives target temperature
    function get_thermostat_target_temperatore() public view returns (uint256){
        return thermostat.target_temperature;
    }
    // retuns if the thermostat is installed or not (ready to start)
    function is_thermostat_installed() public view returns (bool){
        return thermostat.installed;
    }
}
