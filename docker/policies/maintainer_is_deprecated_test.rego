package appshield.DS022

test_denied {
	r := deny with input as {"stages": {"fedora:27": [
		{
			"Cmd": "from",
			"Value": ["fedora:27"],
		},
		{
			"Cmd": "maintainer",
			"Value": ["admin@example.com"],
		},
	]}}

	count(r) == 1
	r[_] == "Shouldn't use : maintainer admin@example.com"
}

test_allowed {
	r := deny with input as {"stages": {"fedora:27": [{
		"Cmd": "from",
		"Value": ["fedora:27"],
	}]}}

	count(r) == 0
}
