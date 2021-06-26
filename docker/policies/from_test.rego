package appshield.dockerfile.DS001

# Test FROM image with latest tag
test_deny_latest_tag_positive {
	r := deny with input as {"stages": {"openjdk": [{"Cmd": "from", "Value": ["openjdk:latest"]}]}}
	count(r) == 1
	startswith(r[_].msg, "Specify tag for image")
}

# Test FROM image with no tag
test_deny_no_tag_positive {
	r := deny with input as {"stages": {"openjdk": [{"Cmd": "from", "Value": ["openjdk"]}]}}
	count(r) == 1
	startswith(r[_].msg, "Specify tag for image")
}

# Test FROM with scratch
test_deny_scratch_positive {
	r := deny with input as {"stages": {"scratch": [{"Cmd": "from", "Value": ["scratch"]}]}}
	count(r) == 0
}
