# LBaaS Database schema
# pemellquist@gmail.com

DROP DATABASE IF EXISTS lbaas;
CREATE DATABASE lbaas;
USE lbaas;


# loadbalancers
CREATE TABLE loadbalancers (
    id BIGINT NOT NULL AUTO_INCREMENT, # unique id for this loadbalancer, generated by DB when record is created
    name VARCHAR(64) NOT NULL, # tenant assigned load balancer name
    tenantid VARCHAR(64) NOT NULL, # tenant id who owns this loadbalancer
    protocol VARCHAR(64) NOT NULL, # loadbalancer protocol used, can be 'HTTP', 'TCP' or 'HTTPS'
    port INT NOT NULL, # TCP port number associated with protocol and used by loadbalancer northbound interface
    status VARCHAR(50) NOT NULL, # current status, see ATLAS API 1.1 for all possible values
    algorithm VARCHAR(80) NOT NULL, # LB Algorithm in use e.g. ROUND_ROBIN, see ATLAS API 1.1 for all possible values
    vips VARCHAR(512) NOT NULL, # list of virtual IPs used for this LB (comma and colon separated)
    nodes VARCHAR(512) NOT NULL, # list of nodes to be LBed accross (comma and colon separated)
    created VARCHAR(64) NOT NULL, # datestamp of when LB was created
    updated VARCHAR(64) NOT NULL, # datestamp of when LB was last updated
    device BIGINT NOT NULL, # reference to associated device OR '0' for unassigned
    PRIMARY KEY (id) # ids are unique accross all LBs
 );

 
 # devices
CREATE TABLE devices (
    id BIGINT NOT NULL AUTO_INCREMENT, # unique id for this device, generated by DB when record is created
    name VARCHAR(64) NOT NULL, # admin assigned device name, this is the unique gearman worker function name
    address VARCHAR(64) NOT NULL, # IPV4 or IPV6 address of devices mgmt interface
    loadbalancers VARCHAR(64) NOT NULL, # Reference to loadbalancers using this device ( JSON array )
    type VARCHAR(64) NOT NULL, # text description of type of device, e.g. 'HAProxy'
    created VARCHAR(64) NOT NULL, # datestamp of when device was created
    updated VARCHAR(64) NOT NULL, # datestamp of when device was last updated
    status VARCHAR(64) NOT NULL, # status of device 'OFFLINE', 'ONLINE', 'ERROR', this value is reported by the device
    PRIMARY KEY (id)
);
