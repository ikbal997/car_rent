class Filter {

  String name;

  Filter(this.name);

}

List<Filter> getFilterList(){
  return <Filter>[
    Filter("Price"),
    Filter("Score"),
    Filter("Type"),
    Filter("Feateres"),
  ];
}