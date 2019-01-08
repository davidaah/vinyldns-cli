load test_helper

@test "groups (when none exist)" {
  run $ew groups

  fixture="$(cat tests/fixtures/groups_none)"

  [ "${output}" = "${fixture}" ]
}

@test "group-create" {
  run $ew group-create \
    --json "$(cat tests/fixtures/group_create_json)"

  fixture="$(cat tests/fixtures/group_create)"

  [ "${output}" = "${fixture}" ]
}

@test "groups (when groups exist)" {
  fixture="$(cat tests/fixtures/groups)"

  $ew groups | grep "${fixture}"
}

@test "group (when the group exists)" {
  fixture="$(cat tests/fixtures/group)"

  $ew group --name "ok-group" | grep "${fixture}"
}

@test "zones (when none exist)" {
  run $ew zones

  fixture="$(cat tests/fixtures/zones_none)"

  [ "${output}" = "${fixture}" ]
}

@test "zone-create (with connection)" {
  run $ew zone-create \
    --name "ok." \
    --email "test@test.com" \
    --admin-group-name "ok-group" \
    --zone-connection-key-name "vinyldns." \
    --zone-connection-key "nzisn+4G2ldMn0q1CV3vsg==" \
    --zone-connection-primary-server "vinyldns-bind9" \
    --transfer-connection-key-name "vinyldns." \
    --transfer-connection-key "nzisn+4G2ldMn0q1CV3vsg==" \
    --transfer-connection-primary-server "vinyldns-bind9"

  fixture="$(cat tests/fixtures/zone_create_connection)"

  [ "${output}" = "${fixture}" ]
}

@test "zone-create (with no connection)" {
  run $ew zone-create \
    --name "vinyldns." \
    --email "admin@test.com" \
    --admin-group-name "ok-group"

  fixture="$(cat tests/fixtures/zone_create_no_connection)"

  [ "${output}" = "${fixture}" ]
}

@test "zone-create (with invalid zone connection)" {
  run $ew zone-create \
    --name "ok-invalid-connection." \
    --email "test@test.com" \
    --admin-group-name "ok-group" \
    --zone-connection-key "nzisn+4G2ldMn0q1CV3vsg==" \
    --zone-connection-primary-server "vinyldns-bind9"

  fixture="$(cat tests/fixtures/zone_create_invalid_zone_connection)"

  [ "${status}" -eq 1 ]
  [ "${output}" = "${fixture}" ]
}

@test "zone-create (with invalid transfer connection)" {
  run $ew zone-create \
    --name "ok-invalid-connection." \
    --email "test@test.com" \
    --admin-group-name "ok-group" \
    --transfer-connection-key "nzisn+4G2ldMn0q1CV3vsg==" \
    --transfer-connection-primary-server "vinyldns-bind9"

  fixture="$(cat tests/fixtures/zone_create_invalid_transfer_connection)"

  [ "${status}" -eq 1 ]
  [ "${output}" = "${fixture}" ]
}
