{
  lib,
  buildGoModule,
  installShellFiles,
}:
buildGoModule rec {
  pname = "incus-compose";
  version = "latest";

  src = ./..;

  vendorHash = "sha256-F22a3qto1YHHNRNqOpbdnKjgZLtglnG7aTcYFbAU52c=";
  subPackages = ["."];

  nativeBuildInputs = [
    installShellFiles
  ];

  postInstall = ''
    installShellCompletion --cmd incus-compose \
      --bash <($out/bin/incus-compose completion bash) \
      --fish <($out/bin/incus-compose completion fish) \
      --zsh <($out/bin/incus-compose completion zsh)
  '';

  ldflags = [
    "-X github.com/bketelsen/incus-compose/cmd.version=${version}"
  ];

  meta = with lib; {
    description = "The missing equivalent for docker-compose in the Incus ecosystem";
    homepage = "https://github.com/bketelsen/incus-compose";
    license = licenses.mit;
    mainProgram = "incus-compose";
    platforms = platforms.linux ++ platforms.darwin;
  };
}
