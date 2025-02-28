package appshield.DS011

test_basic_denied {
	r := deny with input as {"stages": {"alpine:3.3": [
		{
			"Cmd": "from",
			"Value": ["node:carbon2"],
		},
		{
			"Cmd": "copy",
			"Value": ["package.json", "yarn.lock", "my_app"],
		},
	]}}

	count(r) == 1
	r[_] == "Slash is expected at the end of my_app"
}

test_two_args_allowed {
	r := deny with input as {"stages": {"alpine:3.3": [
		{
			"Cmd": "from",
			"Value": ["node:carbon2"],
		},
		{
			"Cmd": "copy",
			"Value": ["package.json", "yarn.lock"],
		},
	]}}

	count(r) == 0
}

test_three_arg_allowed {
	r := deny with input as {"stages": {"alpine:3.3": [
		{
			"Cmd": "from",
			"Value": ["node:carbon2"],
		},
		{
			"Cmd": "copy",
			"Value": ["package.json", "yarn.lock", "myapp/"],
		},
	]}}

	count(r) == 0
}
