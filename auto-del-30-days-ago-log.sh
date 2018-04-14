
#!/bin/sh

find /opt/soft/log/ -mtime +30 -name "*.log" -exec rm -rf {} \;
