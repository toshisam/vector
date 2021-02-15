package metadata

remap: functions: parse_syslog: {
	category:    "Parse"
	description: """
		Parses the `value` in [Syslog](\(urls.syslog)) format.
		"""
	notices: [
		"""
		The function makes a best effort to parse the various Syslog formats out in the wild. This includes
		[RFC 6587](\(urls.syslog_6587)), [RFC 5424](\(urls.syslog_5424)), [RFC 3164](\(urls.syslog_3164)), and other
		common variations (such as the Nginx Syslog style).
		""",
		"""
			All structured data values are returned as strings, it is recommended to manually coerce values as you see fit.
			""",
	]

	arguments: [
		{
			name:        "value"
			description: "The text containing the syslog message to parse."
			required:    true
			type: ["string"]
		},
	]
	internal_failure_reasons: [
		"`value` is not a properly formatted Syslog log",
	]
	return: types: ["object"]

	examples: [
		{
			title: "Parse Syslog log (5424)"
			source: """
				parse_syslog!(
					"<13>1 2020-03-13T20:45:38.119Z dynamicwireless.name non 2426 ID931 [exampleSDID@32473 iut=\"3\" eventSource= \"Application\" eventID=\"1011\"] Try to override the THX port, maybe it will reboot the neural interface!"
				)
				"""
			return: {
				severity:    "notice"
				facility:    "user"
				timestamp:   "2020-03-13T20:45:38.119Z"
				hostname:    "dynamicwireless.name"
				appname:     "non"
				procid:      "2426"
				msgid:       "ID931"
				iut:         "3"
				eventSource: "Application"
				eventID:     "1011"
				message:     "Try to override the THX port, maybe it will reboot the neural interface!"
			}
		},
	]
}
