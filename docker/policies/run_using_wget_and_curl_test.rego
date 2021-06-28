package appshield.DS014

test_basic_denied {
	r := deny with input as {"stages": {
		"gliderlabs/alpine:3.5": [
			{
				"Cmd": "from",
				"Value": ["debian"],
			},
			{
				"Cmd": "run",
				"Value": ["wget http://google.com"],
			},
			{
				"Cmd": "run",
				"Value": ["curl http://bing.com"],
			},
		],
		"baseimage:1.0": [
			{
				"Cmd": "from",
				"Value": ["baseImage"],
			},
			{
				"Cmd": "run",
				"Value": ["wget http://test.com"],
			},
			{
				"Cmd": "run",
				"Value": ["curl http://bing.com"],
			},
			{
				"Cmd": "run",
				"Value": [
					"curl",
					"http://bing.com",
				],
			},
		],
	}}

	count(r) == 1
	r[_] == "Shouldn't use both curl and wget"
}

test_basic_allowed {
	r := deny with input as {"stages": {
		"gliderlabs/alpine:3.5": [
			{
				"Cmd": "from",
				"Value": ["debian"],
			},
			{
				"Cmd": "run",
				"Value": ["curl http://bing.com"],
			},
			{
				"Cmd": "run",
				"Value": ["curl http://google.com"],
			},
		],
		"baseimage:1.0": [
			{
				"Cmd": "from",
				"Value": ["baseImage"],
			},
			{
				"Cmd": "run",
				"Value": [
					"curl",
					"http://bing.com",
				],
			},
		],
	}}

	count(r) == 0
}
