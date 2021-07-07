package appshield.kubernetes.KSV003

import data.lib.kubernetes

default checkCapsDropAll = false

__rego_metadata__ := {
	"id": "KSV003",
	"title": "Unused capabilities should be dropped (drop all)",
	"version": "v1.0.0",
	"severity": "LOW",
	"type": "Kubernetes Security Check",
	"description": "The container should drop all default capabilities and add only those that are needed for its execution.",
	"recommended_actions": "Add 'ALL' to containers[].securityContext.capabilities.drop.",
	"url": "https://kubesec.io/basics/containers-securitycontext-capabilities-drop-index-all/",
}

__rego_input__ := {
	"combine": false,
	"selector": [{"type": "kubernetes"}],
}

# Get all containers which include 'ALL' in security.capabilities.drop
getCapsDropAllContainers[container] {
	allContainers := kubernetes.containers[_]
	allContainers.securityContext.capabilities.drop[_] == "ALL"
	container := allContainers.name
}

# Get all containers which don't include 'ALL' in security.capabilities.drop
getCapsNoDropAllContainers[container] {
	container := kubernetes.containers[_].name
	not getCapsDropAllContainers[container]
}

# checkCapsDropAll is true if capabilities drop does not include 'ALL',
# or if capabilities drop is not specified at all.
checkCapsDropAll {
	count(getCapsNoDropAllContainers) > 0
}

deny[res] {
	checkCapsDropAll

	msg := kubernetes.format(sprintf("Container '%s' of '%s' '%s' in '%s' namespace should add 'ALL' to securityContext.capabilities.drop", [getCapsNoDropAllContainers[_], lower(kubernetes.kind), kubernetes.name, kubernetes.namespace]))

	res := {
		"msg": msg,
		"id": __rego_metadata__.id,
		"title": __rego_metadata__.title,
		"severity": __rego_metadata__.severity,
		"type": __rego_metadata__.type,
	}
}
