---
path: "/learnings/vault"
title: "Learnings: Vault"
---

# <<Learnings_Vault>>

[Vault](http://vaultproject.io) is a secrets store from Hashicorp

# <<Learning_Vault_Development>>

## Steps:

  1. Auth
  2. Auth will return a token <-- this encodes policies the token is allowed for.
  3. Log in with token
  4. get secrets

## <<Learning_Vault_Auth_Providers>>

  * certain websites: Github, AWS
  * LDAP
  * Okta
  * AppRole <-- app token + secret
  * Username + password

# <<Learning_Ops_Vault>>


## See also

  * https://medium.com/qubit-engineering/kubernetes-up-integrated-secrets-configuration-5a15b9f5a6c6
