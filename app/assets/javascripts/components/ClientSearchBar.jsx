
// SEARCH clients FROM PROPS

class ClientSearchBar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clients: []
    }

    this.filterResults = this.filterResults.bind(this);
    this.resetState = this.resetState.bind(this);
    this.visit_new_user_path = this.visit_new_user_path.bind(this);
    this.goToClient = this.goToClient.bind(this);
    this.styleFirstResult = this.styleFirstResult.bind(this);
  }

  styleFirstResult() {
    var all_li = $(".client-search-ul > li"),
        first_li = all_li.first();

    all_li.removeClass("first-li-style");
    first_li.addClass("first-li-style");

  }
  filterResults(e) {
    var input = e.target.value.toLowerCase();
    var data = { keywords: input };
    var that = this;

    $.ajax({
      url: '/search',
      type: 'POST',
      dataType: 'JSON',
      data: data,
      success: function(response) {
        that.setState({clients: response});
        that.styleFirstResult();
      },
      error: function(xhr, status, error) {
        alert('Cannot get data from API: ', error);
      }
    }); 
  }
  componentDidMount() {
    $("#main-wrapper").on("click", this.resetState);
  }

  componentWillUnmount() {
    $("#main-wrapper").off("click", this.resetState);  
  }

  resetState() {
    this.setState({clients: []});
  }

  visit_new_user_path() {
    window.location.href = '/clients/new';
  }

  goToClient(e) {
    if (e.which === 13) {
      e.preventDefault();
      var client_id = this.state.clients[0].id;
      window.location.href = '/clients/' + client_id;
    }
  }

  render() {
    var clientList = this.state.clients.map(function(client) {
      return (
        <ClientSearchResult client={client} key={client.id} />
      );
    });

    return (
      <div>
        <div className="input-group">
          <input
            id='client-search-input'
            className='form-control'
            autoComplete="off"
            placeholder='Jump to client'
            onKeyDown={this.goToClient}
            onChange={this.filterResults}
            type='text' />
            <span 
              className="input-group-addon hover-styling"
              onClick={this.visit_new_user_path}>
                <i className="glyphicon glyphicon-plus" aria-hidden="true"></i>
            </span>
        </div>
          <ul className="list-group client-search-ul">
            {clientList}
          </ul>
      </div>
    );
  }
}

class ClientSearchResult extends React.Component {

  render() {
    var client_path = "/clients/" + this.props.client.id;
    var client_name = this.props.client.first_name + " " + this.props.client.last_name;

    return (
      <li className="client-list-item list-group-item">
        <a href={client_path}>{client_name}</a>
      </li>
    );
  }
}