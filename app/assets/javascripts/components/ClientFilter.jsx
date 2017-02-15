class ClientData extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      data: []
    }
  }

  componentDidMount() {
    var that = this;
    $.ajax({
      url: '/clients.json',
      success: function(data) {
        that.setState({data: data});
      },
      error: function(xhr, status, error) {
        alert('Cannot get data from API: ', error);
      }
    });        
  }

  render() {
    return (
      <ClientFilter data={this.state.data} />
    );
  }
}




// SEARCH CLIENTS FROM PROPS

class ClientFilter extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clients: [],
      isLoading: true
    }

    this.filterResults = this.filterResults.bind(this);
  }

  filterResults(e) {
    var input = e.target.value.toLowerCase();

      if (input.length > 1) {

      var matches = this.props.data.filter(function(item) {
        var name = item.first_name + " " + item.last_name;
        return name.toLowerCase().match(input);
      });

      this.setState({
        clients: matches
      });
    } else {
      this.setState({clients: this.props.data});
    }
  }

  componentWillReceiveProps(nextProps) {
    console.log(nextProps.data);
    this.setState({
      clients: nextProps.data,
      isLoading: false
    });
  }

  render() {
    var clientList = this.state.clients.map(function(client) {
      return (
        <ClientResult client={client} key={client.id} />
      );
    });

    return (
      <div>
        <input
          id='record-input'
          className='form-control'
          autoComplete="off"
          placeholder='Filter clients...'
          onChange={this.filterResults}
          type='text' />
        
        {this.state.isLoading === true
        ? <Loading />
        : <table className="clients table table-striped">
            <thead>
              <tr>
                <td className="text-center" colSpan='2'>Client</td>
                <td>Age</td>
                <td>Last update</td>
                </tr>
            </thead>
            <tbody>
              {clientList}
            </tbody>
          </table>}
      </div>
    );
  }
}

class ClientResult extends React.Component {

 formatDate(date) {
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    var date = new Date(date),
        day = date.getDate(),
        month = months[date.getMonth()],
        year = date.getFullYear();
    
    date = month + ' ' + day + ', ' + year;

    return date;
  }

  render() {
    var client_path = '/clients/' + this.props.client.id;
    var updated_at = this.formatDate(this.props.client.updated_at);
    var client_name = this.props.client.first_name + " " + this.props.client.last_name
    var client_image_path = this.props.client.profile_image.url;
    var birthday = new Date(this.props.client.date_of_birth);
    var today = new Date();
    var age = today.getFullYear() - birthday.getFullYear() - 1;

    return (
      <tr>
        <td><img style={{'width':'35px'}} className='img-responsive img-circle' src={client_image_path} /></td>
        <td><a href={client_path}>{client_name}</a></td>
        <td>{age}</td>
        <td>{updated_at}</td>
      </tr>
    );
  }
}