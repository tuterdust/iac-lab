resource "google_monitoring_dashboard" "compute_instance_dashboard" {
  dashboard_json = jsonencode({
    displayName = "Compute Instance Monitoring Dashboard - ${local.owner_name}"
    gridLayout  = {
      widgets = [
        # Widget: CPU Utilization
        {
          title = "CPU Utilization"
          xyChart = {
            dataSets = [
              {
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.label.instance_id=\"<INSTANCE_ID>\""
                    aggregation = {
                      alignmentPeriod = "60s"
                      perSeriesAligner = "ALIGN_MEAN"
                    }
                  }
                }
                plotType = "LINE"
              }
            ]
            yAxis = {
              label = "CPU Utilization"
              scale = "LINEAR"
            }
          }
        },

        # Widget: Disk Read/Write Operations
        {
          title = "Disk Read/Write Operations"
          xyChart = {
            dataSets = [
              {
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "metric.type=\"compute.googleapis.com/instance/disk/read_ops_count\" AND resource.label.instance_id=\"<INSTANCE_ID>\""
                    aggregation = {
                      alignmentPeriod = "60s"
                      perSeriesAligner = "ALIGN_RATE"
                    }
                  }
                }
                plotType = "LINE"
                targetAxis = "Y1"
              },
              {
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "metric.type=\"compute.googleapis.com/instance/disk/write_ops_count\" AND resource.label.instance_id=\"<INSTANCE_ID>\""
                    aggregation = {
                      alignmentPeriod = "60s"
                      perSeriesAligner = "ALIGN_RATE"
                    }
                  }
                }
                plotType = "LINE"
                targetAxis = "Y2"
              }
            ]
            yAxis = {
              label = "Read Ops"
              scale = "LINEAR"
            }
            y2Axis = {
              label = "Write Ops"
              scale = "LINEAR"
            }
          }
        },

        # Widget: Network Throughput
        {
          title = "Network Throughput"
          xyChart = {
            dataSets = [
              {
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "metric.type=\"compute.googleapis.com/instance/network/sent_bytes_count\" AND resource.label.instance_id=\"<INSTANCE_ID>\""
                    aggregation = {
                      alignmentPeriod = "60s"
                      perSeriesAligner = "ALIGN_RATE"
                    }
                  }
                }
                plotType = "LINE"
              },
              {
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "metric.type=\"compute.googleapis.com/instance/network/received_bytes_count\" AND resource.label.instance_id=\"<INSTANCE_ID>\""
                    aggregation = {
                      alignmentPeriod = "60s"
                      perSeriesAligner = "ALIGN_RATE"
                    }
                  }
                }
                plotType = "LINE"
              }
            ]
            yAxis = {
              label = "Bytes/sec"
              scale = "LINEAR"
            }
          }
        }
      ]
    }
  })
}
