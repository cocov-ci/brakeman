Cocov::PluginKit.run do
  begin
    exec("brakeman -A --no-exit-on-warn -o /tmp/output.json", env: ENV)
  rescue PluginKit::Exec::ExecutionError => e
    puts e.stdout
    puts e.stderr
    puts "ERROR: Process brakeman exited with status #{e.status}"
    exit 1
  end

  data = JSON.load_file("/tmp/output.json")
  data["warnings"].each do |entry|
    emit_issue(kind: :security, file: entry["file"], line_start: entry["line"], line_end: entry["line"], message: entry["message"], uid: entry["fingerprint"])
  end
end
