# Providing metrics from the Geiger Counter as a service
_author_: *tuan t. pham*


## Requirements
* [GMC][0] device(s)
* [pygmc][1] Python package
* USB cable connected to the computer
* computer that runs Linux
* Docker if you use Docker image
* [`docker-compose`][2] if you want to use `docker-compose`

## Build Docker image
```bash
make
```

## Run as a docker service
```bash
docker-compose up -d
```

## Run python script
```bash
pip install -r requirements.txt
./gmc-service.py
```

## Example usage
```bash
# On one terminal
docker-compose up -d

# On another terminal
$ curl localhost:2380/config
{
  "Alarm_CPM": 100,
  "Alarm_Volume": 15,
  "Calibration_CPM_1": 986,
  "Calibration_CPM_2": 8546,
  "Calibration_CPM_3": 16408,
  "Calibration_CPM_4": 37970,
  "Calibration_CPM_5": 76010,
  "Calibration_CPM_6": 139671,
  "Calibration_USV_1": 10.0,
  "Calibration_USV_2": 100.0,
  "Calibration_USV_3": 200.0,
  "Calibration_USV_4": 500.0,
  "Calibration_USV_5": 1000.0,
  "Calibration_USV_6": 2000.0,
  "Click_Sound": 0,
  "Fast_Estimate_Time": 3,
  "LCD_Backlight_Level": 0,
  "LED": 1,
  "Power": 0,
  "Power_Saving_Mode": 0,
  "Save_Mode": 1,
  "Speaker_Volume": 15,
  "Theme": 0,
  "Tube_Voltage": 44,
  "Vibration": 1

$ curl localhost:2380/metrics
[
  {
    "cpm": 27,
    "version": "GMC-800Re1.18"
  }
]
```


[0]: https://gqelectronicsllc.com
[1]: https://github.com/Wikilicious/pygmc
[2]: https://github.com/docker/compose/releases
