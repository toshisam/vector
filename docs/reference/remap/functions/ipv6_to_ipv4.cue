package metadata

remap: functions: ipv6_to_ipv4: {
	category: "IP"
	description: """
		Converts the `ip` to an IPv4 address.
		"""

	arguments: [
		{
			name:        "ip"
			description: "The IPv4 mapped IPv6 address to convert."
			required:    true
			type: ["string"]
		},
	]
	internal_failure_reasons: [
		"`ip` is not a valid IP address",
		"`ip` is an IPv6 address that is not compatible with IPv4",
	]
	return: {
		types: ["string"]
		rules: [
			"If the parameter is already an IPv4 address it is passed through untouched. If it is an IPv6 address it has to be an IPv4 compatible address.",
		]
	}

	examples: [
		{
			title: "IPv6 to IPv4"
			source: #"""
				ipv6_to_ipv4!("::ffff:192.168.0.1")
				"""#
			return: "192.168.0.1"
		},
	]
}
