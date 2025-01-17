{ lib
, asyncssh
, bcrypt
, buildPythonPackage
, fetchFromGitHub
, fsspec
, mock-ssh-server
, pytest-asyncio
, pytestCheckHook
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "sshfs";
  version = "2023.1.0";

  src = fetchFromGitHub {
    owner = "fsspec";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-TETxjBI4T8dgmtCtx/lq2LIIwyFsAMWY6xdm7+Qsjb0=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    asyncssh
    bcrypt
    fsspec
  ];

  nativeCheckInputs = [
    mock-ssh-server
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "sshfs"
  ];

  meta = with lib; {
    description = "SSH/SFTP implementation for fsspec";
    homepage = "https://github.com/fsspec/sshfs/";
    changelog = "https://github.com/fsspec/sshfs/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ melling ];
  };
}
