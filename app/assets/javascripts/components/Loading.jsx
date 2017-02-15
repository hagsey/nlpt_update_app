var styles = {
  container: {
    position: 'fixed',
    left: 0,
    right: 0,
    top: 0,
    bottom: 0,
    fontSize: '55px'
  },
  content: {
    fontSize: '18px',
    color: '#cdcdcd'
  }
}

var Loading = React.createClass({
  getInitialState: function () {
    return {
      text: 'Loading.',
      speed: 50
    }
  },
  componentDidMount: function () {
    this.interval = setInterval(function () {
        this.setState({
          text: this.state.text + '.'
      })
    }.bind(this), this.state.speed)
  },
  componentWillUnmount: function () {
    window.clearInterval(this.interval)
  },
  render: function () {
    return (
      <div>
        <p style={styles.content}>{this.state.text}</p>
      </div>
    )
  }
});