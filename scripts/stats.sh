# Get System Stats

# Write File to Desktop with System Info #
system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' >> ~/Desktop/system_info.txt						# Serial Number
system_profiler SPHardwareDataType | awk '/Hardware UUID/ {print $3}' >> ~/Desktop/system_info.txt				# UDID
system_profiler SPNetworkLocationDataType | awk '/Hardware \(MAC\)/ {print $4}' >> ~/Desktop/system_info.txt	# Mac Address
system_profiler SPHardwareDataType | awk '/Model Name/ {print $0}' >> ~/Desktop/system_info.txt					# Model Name
system_profiler SPHardwareDataType | awk '/Processor Name/ {print $0}' >> ~/Desktop/system_info.txt				# Processor Name
system_profiler SPHardwareDataType | awk '/Processor Speed/ {print $0}' >> ~/Desktop/system_info.txt			# Processor Speed
system_profiler SPHardwareDataType | awk '/Memory/ {print $2 $3 $4}' >> ~/Desktop/system_info.txt				# RAM
