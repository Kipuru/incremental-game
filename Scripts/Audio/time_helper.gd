class_name TimeHelper

# Converts seconds to minutes, rounded down
static func seconds_to_minutes(seconds: float) -> int:
	return floori(seconds / 60.)

# Returns remainder after dividing by 60, rounded down
static func seconds_remainder(seconds: float) -> int:
	return floori(seconds) % 60

# Converts seconds to m:ss format
static func seconds_to_min_sec_string(seconds: float) -> String:
	var m_str = str(seconds_to_minutes(seconds))
	var s_str = str(seconds_remainder(seconds))
	if s_str.length() < 2:
		s_str = "0" + s_str
	
	return m_str + ":" + s_str
