var React = require('react');
var Router = require('react-router'); 
var DefaultRoute = Router.DefaultRoute;
var Link = Router.Link;
var Route = Router.Route;
var RouteHandler = Router.RouteHandler;

var App = React.createClass({
  render: function () {
    return (
      <div>
        <header>
          <ul>
            <li><Link to="app">Dashboard</Link></li>
            <li><Link to="inbox">Inbox</Link></li>
            <li><Link to="calendar">Calendar</Link></li>
          </ul>
          Logged in as Jane
        </header>

//<RouteHandler/>コンポーネントをrenderすることで、
//ルーティングで定義された全てのアクティブな子コンポーネントを呼び出す。        
        <RouteHandler/>
      </div>
    );
  }
});

//アプリケーションのurlの階層構造をネストされた<Route/>タグで定義し、
//各<Route/>のhandlerにReactのコンポーネントを紐付け、
//render時には、アクティブな<Route/>のhandlerがコンポーネントを呼び出し、
//それらが融合されて表出される。
var routes = (
  <Route name="app" path="/" handler={App}>
    <Route name="inbox" handler={Inbox}/>
    <Route name="calendar" handler={Calendar}/>
    <DefaultRoute handler={Dashboard}/>
  </Route>
);

//React RouterはリクエストされたURLに最も深くマッチする<Route/>を探し出し、
//その木構造の中での枝に含まれる全ての<Route/>をアクティブにする。
Router.run(routes, function (Handler) {
  React.render(<Handler/>, document.body);
});