import React from 'react'
import { render } from 'react-dom'
import { hashHistory, Router, Route, Link, browserHistory } from 'react-router'

var IndexRoute = Router.IndexRoute;

var Index = React.createClass({
  render: function () {
    return (
      <div>
        <header>
          this is header
        </header>
        {this.props.children}              //routerで切り替えたい箇所
        <footer>
          this is footer
        </footer>
      </div>
    );
  }
});

var Entrance = React.createClass({
  render: function () {
    return (
      <div>
        <span>ENTRANCE</span>
      </div>
    );
  }
});

var NotFound = React.createClass({
  render: function () {
    return (
      <div>
        <span>NOT FOUND</span>
      </div>
    );
  }
});

class App extends React.Component {
  render() {
    return (
      <div className='container'>
      これいい
      </div>
    );
  }
}

// 1つ1つの投稿
const Post = props => {
  return (
    <div className='panel panel-default'>
      <div className='panel-heading'>
        <h4 className='panel-title'>{props.data.title}</h4>
      </div>
      <div className='panel-body'>
        {props.data.body}
        <input className='btn btn-default pull-right' type='submit' value='delete' />
      </div>
    </div>
  );
};
var routes = (
  <Router history={browserHistory}>
    <Route  path="/" component={App}>
    </Route>
  </Router>
);


// Declarative route configuration (could also load this config lazily
// instead, all you really need is a single root route, you don't need to
// colocate the entire config).
render((
    routes
), document.getElementById('root'))