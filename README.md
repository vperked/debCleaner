# System Cleaner

A comprehensive system cleaning tool for Debian-based Linux systems.

## Features

- Package system cleanup
- Old kernel removal
- Log file cleanup
- Cache cleanup
- System status reporting

## Installation

1. Clone the repository:
```bash
git clone https://github.com/vperked/sysCleaner.git
cd sysCleaner
```

2. Make the script executable:
```bash
chmod +x src/clean.sh
```

## Usage

Run the script as root:
```bash
sudo ./src/clean.sh
```

## Scheduling with Cron

To run the script automatically, you can set up a cron job:

1. Open the root crontab:
```bash
sudo crontab -e
```

2. Add one of these example schedules:
```bash
# Run weekly (Sunday at 2 AM)
0 2 * * 0 /path/to/sysCleaner/src/clean.sh

# Run monthly (1st of each month at 3 AM)
0 3 1 * * /path/to/sysCleaner/src/clean.sh

# Run daily at 4 AM
0 4 * * * /path/to/sysCleaner/src/clean.sh
```

Make sure to replace `/path/to/sysCleaner` with the actual path to your installation.

To verify your cron jobs:
```bash
sudo crontab -l
```

## Configuration

Edit the following variables in the script to customize behavior:
- `LOG_FILE`: Location of log file
- `BACKUP_DIR`: Directory for backups (if enabled)
- `DEBUG`: Set to true for verbose output

## Safety

⚠️ This script performs system-wide cleanup operations. Always backup important data before running.

## License

MIT License

## Contributing

1. Fork the repository
2. Create your feature branch
3. Submit a pull request

