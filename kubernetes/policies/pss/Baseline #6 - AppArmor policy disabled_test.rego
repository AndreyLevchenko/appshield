package appshield.kubernetes.KSV002

test_custom_deny {
	r := deny with input as {
		"apiVersion": "v1",
		"kind": "Pod",
		"metadata": {
			"annotations": {"container.apparmor.security.beta.kubernetes.io/hello": "custom"},
			"name": "hello-apparmor",
		},
		"spec": {"containers": [{
			"command": [
				"sh",
				"-c",
				"echo 'Hello AppArmor!' && sleep 1h",
			],
			"image": "busybox",
			"name": "hello",
		}]},
	}
	count(r) > 0
}

test_undefined_allowed {
	r := deny with input as {
		"apiVersion": "v1",
		"kind": "Pod",
		"metadata": {
			"name": "hello-apparmor",
		},
		"spec": {"containers": [{
			"command": [
				"sh",
				"-c",
				"echo 'Hello AppArmor!' && sleep 1h",
			],
			"image": "busybox",
			"name": "hello",
		}]},
	}
	count(r) == 0
}
test_runtime_default_allowed {
	r := deny with input as {
		"apiVersion": "v1",
		"kind": "Pod",
		"metadata": {
			"annotations": {"container.apparmor.security.beta.kubernetes.io/hello": "runtime/default"},
			"name": "hello-apparmor",
		},
		"spec": {"containers": [{
			"command": [
				"sh",
				"-c",
				"echo 'Hello AppArmor!' && sleep 1h",
			],
			"image": "busybox",
			"name": "hello",
		}]},
	}
	count(r) == 0
}