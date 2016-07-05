cd ~
service docker start
cp -a /sshkeys /root/.ssh
cd /root/.ssh && ls | grep -v '\.pub$' | xargs chmod 700
git clone git@github.com:docker/moby.git
cd moby
git checkout $branch
make
cp -a ./alpine/initrd.img.gz /output/v1/moby/initrd.img
cp -a ./alpine/mobylinux-efi.iso /output/win/src/Resources/mobylinux.iso
cp -a ./alpine/kernel/vmlinuz64 /output/v1/moby/vmlinuz64
git rev-parse HEAD > /output/v1/moby/COMMIT
