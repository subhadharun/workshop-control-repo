plan tools::uptime (
  TargetSpec $nodes,
) {
  run_task('tools::uptime', $nodes, args => '-s')
}
