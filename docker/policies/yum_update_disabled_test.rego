package appshield.DS008

#	regex.match("(yum update)|(yum update-to)|(yum upgrade)|(yum upgrade-to)", merged)

test_failUpdate_update {
	failUpdate with input as [{"Cmd": "run", "Value": ["yum update"]}]
}

test_failUpdate_update_to {
	failUpdate with input as [{"Cmd": "run", "Value": ["yum update-to"]}]
}

test_failUpdate_upgrade {
	failUpdate with input as [{"Cmd": "run", "Value": ["yum upgrade"]}]
}

test_failUpdate_upgrade_to {
	failUpdate with input as [{"Cmd": "run", "Value": ["yum upgrade-to"]}]
}

test_entry_point_positive {
	r := deny with input as [{"Cmd": "run", "Value": ["yum upgrade"]}]

	count(r) > 0
	startswith(r[_], "Shouldn't use yum upgrade")
}

test_entry_point_negative {
	r := deny with input as [{"Cmd": "run", "Value": ["apt-get install"]}]

	count(r) == 0
}
