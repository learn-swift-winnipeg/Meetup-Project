import React, { Component } from 'react';
import { BrowserRouter, Route, Redirect } from 'react-router-dom';
import logo from '../swift_logo.svg';
import '../App.css';
import { createOauthFlow } from 'react-oauth-flow';
import Login from './login';

const { Sender, Receiver} = createOauthFlow({
  authorizeUrl: process.env.REACT_APP_AUTH_URL,
  tokenUrl: process.env.REACT_APP_TOKEN_URL,
  clientId: process.env.REACT_APP_MEETUP_CLIENT_ID,
  redirectUri: process.env.REACT_APP_MEETUP_REDIRECT_URI,
});

class App extends Component {
  handleSuccess = () => {
      return "SUCESS"
  };


  handleError = async error => {
    console.error('Error: ', error.message);

    const text = await error.response.text();
    console.log(text);
  };

  render() {
    return(
      <BrowserRouter>
        <div className="App">
          <header className="App-header">
            <img src={logo} className="App-logo" alt="logo" />
            <h1 className="App-title">Welcome Learn Swift Winnipeg Meetup Web UI</h1>
          </header>

          <Route
            exact
            path="/"
            render={() => (
              <div>
                <Sender
                  state={{ to: '/user/create' }}
                  render={({ url }) => <a href={url}>Connect to Meetup</a>}
                />
              </div>
            )}
          />

          <Route
            exact
            path="/auth/meetup"
            render={({ location }) => (
              <Receiver
                location={location}
                onAuthSuccess={this.handleSuccess}
                onAuthError={this.handleError}
                render={({ processing, state, error }) => {
                  if (processing) {
                    return <p>Processing!</p>;
                  }

                  if (error) {
                    return <p style={{ color: 'red' }}>{error.message}</p>;
                  }

                  return <Redirect to={state.to} />;
                }}
              />
            )}
          />

          <Route
            exact
            path="/user/create"
            render={() => <Login />}
          />
        </div>
      </BrowserRouter>

  );
  }

}

export default App;