plan tools::custom(
  TargetSpec $nodes,
) {
  apply_prep($nodes)

  apply($nodes) {
    class { 'my_mod':
      content => 'aaaaaa',
    }
  }
}
