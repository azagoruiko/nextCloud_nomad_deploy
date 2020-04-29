job "nextcloud-job" {
  datacenters = ["home"]
  type        = "service"

  group "nextcloud-group" {
    count = 1

    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    task "nextcloud-task" {
      driver = "docker"
      env {
        POSTGRES_DB="nextcloud"
        POSTGRES_HOST="192.168.0.21"
        POSTGRES_PORT=5432
      }
      template {
        data = <<EOH
POSTGRES_USER="{{ key "postgres.jdbc.user" }}"
POSTGRES_PASSWORD="{{ key "postgres.jdbc.password" }}"
EOH
        destination = "secrets.env"
        env = true
      }
      config {
        image = "127.0.0.1:9999/docker/nextcloud:0.0.1"
        privileged = true
        args = [
        ]

        port_map {
          web = 80
        }

        volumes = [
          "/var/nfs/:/var/nfs/",
        ]
      }

      resources {
        cpu    = 700
        memory = 1024

        network {
          mbits = 30
          port  "web" {
          }
        }
      }

      service {
        name = "nextcloud-service"
        port = "web"
        tags = ["urlprefix-/nextcloud strip=/nextcloud"]

        check {
          type     = "http"
          path     = "/status.php"
          interval = "20s"
          timeout  = "2s"
        }
      }
    }
  }
}

