```bash
nix build .#vm;
openstack image create --disk-format qcow2 --container-format bare --file ./result/nixos.qcow2 "nixos-$(date --iso-8601)" --progress
```