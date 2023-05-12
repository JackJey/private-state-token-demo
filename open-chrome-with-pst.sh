#!/usr/bin/env zsh

## for glitch
open -a Google\ Chrome\ Dev \
  --args \
  --enable-blink-features=PrivateStateTokens,PrivateStateTokensAlwaysAllowIssuance,PrivacySandboxSettings3 \
  --additional-private-state-token-key-commitments='{ "https://private-state-token-issuer.glitch.me": { "PrivateStateTokenV1VOPRF": { "protocol_version": "PrivateStateTokenV1VOPRF", "id": 1, "batchsize": 1, "keys": { "1": { "Y": "AAAAAQQ7W5gOubJT3kTpzNGsekT9RZPXgXGrOMB2+QPw/ZzAuLrM3kc8eyHuTc1KmKjH4sh5+ev5GCI4HVVd46o6rWvNvk0iZQtVuUPhT8X54Ajebng8v5zUnpnPuTjGqlc7+MM=", "expiry": "1715356984440000" } } } } }'

# {
#  "PrivateStateTokenV1VOPRF": {
#   "protocol_version": "PrivateStateTokenV1VOPRF",
#   "id": 1,
#   "batchsize": 1,
#   "keys": {
#    "1": {
#     "Y": "AAAAAQQ7W5gOubJT3kTpzNGsekT9RZPXgXGrOMB2+QPw/ZzAuLrM3kc8eyHuTc1KmKjH4sh5+ev5GCI4HVVd46o6rWvNvk0iZQtVuUPhT8X54Ajebng8v5zUnpnPuTjGqlc7+MM=",
#     "expiry": "1715356984440000"
#    }
#   }
#  }
# }

## for trusttoken.dev
# open -a Google\ Chrome\ Canary \
#   --args \
#   --enable-blink-features=PrivateStateTokens,PrivateStateTokensAlwaysAllowIssuance \
#   --enable-features=PrivacySandboxSettings3 \
#   --additional-private-state-token-key-commitments='{"PrivateStateTokenV1VOPRF": {"protocol_version": "PrivateStateTokenV1VOPRF", "batchsize": 1, "keys": {"0": {"Y": "AAAAAARfsssbDuePtDrNZ3lM/UURh5OQuxpiyHSHc1pdoKOlfZ1EEPEWMyjMs4RUBi04PGIH/2Ydu9DkhJBPOB8L3KvWrGzHY19bBVuYgypnPi1bFWV8FiVS7LTk4bQ6bUELZS8=", "expiry": "1767139200000000"}, "1": {"Y": "AAAAAQQf7weUF/kePEPj0OSOYXJFl5MtMxr8g0svnv/prKQJK/hXrKqyQCrfxWJaQcKvj0MqtJcAA0CMZUGO2+cEXXgVNsa9Rw3ozo5a69bRrcvwnu+DFfB/qrA+8vqB7HxSRyc=", "expiry": "1767139200000000"}, "2": {"Y": "AAAAAgQLbdTSLHbxKCt47+OFNTVxvvVenvsWvmB0GQrm0B7+fb+4Cr8DgkZ7O6cJ1XtJBN6pBocANfPtUMINbsFsrUrJILKj9zGuFbtlVUCnNTMxjgk6jhDGtvIrzoT2Tgj/Mqo=", "expiry": "1767139200000000"}, "3": {"Y": "AAAAAwSTuOrMb7Azhj0tzR0SBazJADihIRGWM3JMfCzAv38M7dAt3PrLa+yKQ2yJiyH43gbZo61I/AThxsw/55Bpo2mOZRfiRgYLiuuUceb5JJ69OLrkOuwAUyDJFsNGNXBy2m4=", "expiry": "1767139200000000"}, "4": {"Y": "AAAABASWQfNzun5KImUlkOvsg4iud4R4U+sOa2VjlUDMkrWB1S+q1qL/GuD3k687DQF/RfvbIbIeVkJZNyjobNqW7X4TsXU+lako/gxOBRqzl9aHaoMV9gk6EbvibY/XMD5AFDQ=", "expiry": "1767139200000000"}, "5": {"Y": "AAAABQR38by110bTSikIvk/oYI8eav69TFj3VrUNyc/Cj4dElEUIPqdpGUr2x+zH0vAs8+HD3lagql2JkzqncOEC5o6NX8bzWTTBxyNy7+uj9dYxy23jG0CFRxvJzLCRRTjuFZA=", "expiry": "1767139200000000"}}, "id": 1}}'

# {
#   "PrivateStateTokenV1VOPRF": {
#     "protocol_version": "PrivateStateTokenV1VOPRF",
#     "id": 1,
#     "batchsize": 1,
#     "keys": {
#       "0": {
#         "Y": "AAAAAARfsssbDuePtDrNZ3lM/UURh5OQuxpiyHSHc1pdoKOlfZ1EEPEWMyjMs4RUBi04PGIH/2Ydu9DkhJBPOB8L3KvWrGzHY19bBVuYgypnPi1bFWV8FiVS7LTk4bQ6bUELZS8=",
#         "expiry": "1767139200000000"
#       },
#       "1": {
#         "Y": "AAAAAQQf7weUF/kePEPj0OSOYXJFl5MtMxr8g0svnv/prKQJK/hXrKqyQCrfxWJaQcKvj0MqtJcAA0CMZUGO2+cEXXgVNsa9Rw3ozo5a69bRrcvwnu+DFfB/qrA+8vqB7HxSRyc=",
#         "expiry": "1767139200000000"
#       },
#       "2": {
#         "Y": "AAAAAgQLbdTSLHbxKCt47+OFNTVxvvVenvsWvmB0GQrm0B7+fb+4Cr8DgkZ7O6cJ1XtJBN6pBocANfPtUMINbsFsrUrJILKj9zGuFbtlVUCnNTMxjgk6jhDGtvIrzoT2Tgj/Mqo=",
#         "expiry": "1767139200000000"
#       },
#       "3": {
#         "Y": "AAAAAwSTuOrMb7Azhj0tzR0SBazJADihIRGWM3JMfCzAv38M7dAt3PrLa+yKQ2yJiyH43gbZo61I/AThxsw/55Bpo2mOZRfiRgYLiuuUceb5JJ69OLrkOuwAUyDJFsNGNXBy2m4=",
#         "expiry": "1767139200000000"
#       },
#       "4": {
#         "Y": "AAAABASWQfNzun5KImUlkOvsg4iud4R4U+sOa2VjlUDMkrWB1S+q1qL/GuD3k687DQF/RfvbIbIeVkJZNyjobNqW7X4TsXU+lako/gxOBRqzl9aHaoMV9gk6EbvibY/XMD5AFDQ=",
#         "expiry": "1767139200000000"
#       },
#       "5": {
#         "Y": "AAAABQR38by110bTSikIvk/oYI8eav69TFj3VrUNyc/Cj4dElEUIPqdpGUr2x+zH0vAs8+HD3lagql2JkzqncOEC5o6NX8bzWTTBxyNy7+uj9dYxy23jG0CFRxvJzLCRRTjuFZA=",
#         "expiry": "1767139200000000"
#       }
#     }
#   }
# }
