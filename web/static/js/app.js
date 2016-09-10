import React from 'react';
var ReactDOM = require('react-dom');
import $ from 'jquery';

var SearchPanel = React.createClass({
    render: function() {
        return (
            <div className="row">
                <div className="one-fourth column">
                    Filter: &nbsp;
                    <input ref='search' type='text' value={this.props.search} onChange={this.onSearchChanged} />
                    {this.props.search?<button onClick={this.props.onClearSearch} >x</button>:null}
                </div>
            </div>
        )
    },
    onSearchChanged: function() {
        var query = ReactDOM.findDOMNode(this.refs.search).value;
        this.props.onSearchChanged(query);
    }
});

var BookTableRow = React.createClass({
    render: function() {
        return (
            <tr>
                <td>{this.props.book.title}</td>
                <td>{this.props.book.category}</td>
                <td><a href='#' onClick={this.onClick}>Edit</a></td>
            </tr>
        );
    },
    onClick: function(id) {
        this.props.handleEditClickPanel(this.props.book.id);
    }
});

var BookTable = React.createClass({
    render: function() {
        var rows = [];
        console.log(this.props.books);
        for(var i = 0; i < this.props.books.length; i++) {
            var book = this.props.books[i];
            rows.push(<BookTableRow key={book.id} book={book} handleEditClickPanel={this.props.handleEditClickPanel}  />);
        }
        // なぜかforEachできない
        // this.props.books.forEach(function(book) {
        //     rows.push(<BookTableRow key={book.id} book={book} handleEditClickPanel={this.props.handleEditClickPanel}  />);
        // }.bind(this));
        return (
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>{rows}</tbody>
            </table>
        );
    }
});

var BookForm = React.createClass({
    render: function() {
        return(
            <form onSubmit={this.props.handleSubmitClick}>
                <label forHtml='title'>Title</label><input ref='title' name='title' type='text' value={this.props.book.title} onChange={this.onChange}/>
                <label forHtml='category'>Category</label>
                <select ref='category' name='category' value={this.props.book.category} onChange={this.onChange} >
                    <option value='CRIME' >Crime</option>
                    <option value='HISTORY'>History</option>
                    <option value='HORROR'>Horror</option>
                    <option value='SCIFI'>SciFi</option>
                </select>
                <br />
                <input type='submit' value={this.props.book.id?"Save (id = " +this.props.book.id+ ")":"Add"} />
                {this.props.book.id?<button onClick={this.props.handleDeleteClick}>Delete</button>:null}
                {this.props.book.id?<button onClick={this.props.handleCancelClick}>Cancel</button>:null}
                {this.props.message?<div>{this.props.message}</div>:null}
            </form>
        );
    },
    onChange: function() {
        var title = ReactDOM.findDOMNode(this.refs.title).value;
        var category = ReactDOM.findDOMNode(this.refs.category).value;
        this.props.handleChange(title, category);
    }
});

var BookPanel = React.createClass({
    getInitialState: function() {
        return {
            books: [],
            editingBook: {
                title:"",
                category:"",
            },
            search:"",
            message:""
        };
    },
    render: function() {
        return(
            <div className="row">
                <div className="one-half column">
                    <SearchPanel
                        search={this.state.search}
                        onSearchChanged={this.onSearchChanged}
                        onClearSearch={this.onClearSearch}
                    />
                    <BookTable books={this.state.books} handleEditClickPanel={this.handleEditClickPanel} />
                </div>
                <div className="one-half column">
                    <BookForm 
                        book={this.state.editingBook} 
                        message={this.state.message} 
                        handleChange={this.handleChange}
                        handleSubmitClick={this.handleSubmitClick}
                        handleCancelClick={this.handleCancelClick}
                        handleDeleteClick={this.handleDeleteClick}
                    />
                </div>
            </div>
        );
    },
    componentDidMount: function() {
        this.reloadBooks('');
    },
    onSearchChanged: function(query) {
        if (this.promise) {
            clearInterval(this.promise)
        }
        this.setState({
            search: query
        });
        this.promise = setTimeout(function () {
            this.reloadBooks(query);
        }.bind(this), 200);
    },
    onClearSearch: function() {
        this.setState({
            search: ''
        });
        this.reloadBooks('');
    },
    // Edit押下した瞬間
    handleEditClickPanel: function(id) {
        console.log(id);
        var book = $.extend({}, this.state.books.filter(function(x) {
            return x.id == id;
        })[0] );
        
        this.setState({
            editingBook: book,
            message: ''
        });
    },
    // 入力した瞬間
    handleChange: function(title, category) {
        console.log(title);
        this.setState({
            editingBook: {
                title: title,
                category: category,
                id: this.state.editingBook.id
            }
        });
    },
    handleCancelClick: function(e) {
        this.setState({
            editingBook: {}
        });
    },    
    reloadBooks: function(query) {
        console.log(this.props.url);
        $.ajax({
            // url: this.props.url+'?search='+query,
            url: this.props.url,
            dataType: 'json',
            // これら必須
            contentType: 'application/json',
            beforeSend: function(req) {
                req.setRequestHeader('Accept', 'application/json');
            },
            cache: false,
            success: function(data) {
        console.log(data);
                this.setState({
                    books: data.data.reverse(),
                    // books: data.reverse(),
                    search: query
                });
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
                this.setState({
                    message: err.toString()
                });
            }.bind(this)
        });
    },
    handleSubmitClick: function(e) {
        e.preventDefault();
        if(this.state.editingBook.id) {
            // 編集
            $.ajax({
                url: this.props.url+this.state.editingBook.id,
                dataType: 'json',
                method: 'PUT',
                // これら必須
                contentType: 'application/json',
                beforeSend: function(req) {
                    req.setRequestHeader('Accept', 'application/json');
                },
                // data:this.state.editingBook,
                data: JSON.stringify({book:this.state.editingBook}),
                cache: false,
                success: function(data) {
                    this.setState({
                        message: "Successfully updated book!"
                    });
                    this.reloadBooks('');
                }.bind(this),
                error: function(xhr, status, err) {
                    console.error(this.props.url, status, err.toString());
                    this.setState({
                        message: err.toString()
                    });
                }.bind(this)
            });
        } else {
            // 新規
            $.ajax({
                url: this.props.url,
                dataType: 'json',
                method: 'POST',
                // data:this.state.editingBook,
                data: JSON.stringify({book:this.state.editingBook}),
                // これら必須
                contentType: 'application/json',
                beforeSend: function(req) {
                    req.setRequestHeader('Accept', 'application/json');
                },
                cache: false,
                success: function(data) {
                    this.setState({
                        message: "Successfully added book!"
                    });
                    this.reloadBooks('');
                }.bind(this),
                error: function(xhr, status, err) {
                    console.error(this.props.url, status, err.toString());
                    this.setState({
                        message: err.toString()
                    });
                }.bind(this)
            });
        }
        this.setState({
            editingBook: {}
        });
    },
    handleDeleteClick: function(e) {
        e.preventDefault();
        $.ajax({
            url: this.props.url+this.state.editingBook.id,
            method: 'DELETE',
            cache: false,
            success: function(data) {
                this.setState({
                    message: "Successfully deleted book!",
                    editingBook: {}
                });
                this.reloadBooks('');
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
                this.setState({
                    message: err.toString()
                });
            }.bind(this)
        });
    },
});

ReactDOM.render(<BookPanel url='/api/books/' />, document.getElementById('content'));
