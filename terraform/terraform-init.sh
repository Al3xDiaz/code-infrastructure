#! /bin/sh
terraform init \
    -backend-config="address=https://gitlab.com/api/v4/projects/42073065/terraform/state/old-state-name" \
    -backend-config="lock_address=https://gitlab.com/api/v4/projects/42073065/terraform/state/old-state-name/lock" \
    -backend-config="unlock_address=https://gitlab.com/api/v4/projects/42073065/terraform/state/old-state-name/lock" \
    -backend-config="username=Al3xDiaz" \
    -backend-config="password=$GITLAB_ACCESS_TOKEN" \
    -backend-config="lock_method=POST" \
    -backend-config="unlock_method=DELETE" \
    -backend-config="retry_wait_min=5" \
    -reconfigure