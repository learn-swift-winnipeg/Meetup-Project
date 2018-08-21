import React, { Component } from 'react';

class Login extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {
                firstName: "",
                lastName: "",
                code: ""
            }
        }

        this.updateUser = this.updateUser.bind(this);
        this.createUser = this.createUser.bind(this);
    }

    componentWillMount() {
        var url = new URL(window.location.href)
        var code = url.searchParams.get("code");

        this.setState({
            user: {
                ...this.state.user,
                code: code
            }
        })
    }

    createUser() {
        // TODO: Make this work for more then just Localhost
        return fetch("http://localhost:8080/user/create",{
            method: 'POST',
            credentials: 'same-origin',
            headers: {
                'Accept' : 'application/json',
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                firstName: this.state.firstName,
                lastName: this.state.lastName,
                code: this.state.code,
            })
        }).then(response => {
            console.log("RESPONSE: ", response)
            return response
        }).catch(err => console.log("ERR: ", err));
    }

    updateUser(evt) {
        this.setState({
            user: {
                ...this.state.user,
                [evt.target.name]: evt.target.value
            }
        })
    }

    render() {
        console.log("STATE: ", this.state)
        return (
            <div><h1>User Logged</h1></div>
        )
    }
}

export default Login;