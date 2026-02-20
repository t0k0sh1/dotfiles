dcr() {
  if ! command -v docker &>/dev/null; then
    echo "Error: docker command not found" >&2
    return 1
  fi

  if [[ ! -f "docker-compose.yml" && ! -f "docker-compose.yaml" && ! -f "compose.yml" && ! -f "compose.yaml" ]]; then
    echo "Error: No compose file found in current directory" >&2
    return 1
  fi

  docker compose down -v && docker compose up -d
}
