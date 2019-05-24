/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {StyleSheet, View, Alert, TouchableOpacity, Text} from 'react-native';
import MyView from './components/MyView'
type Props = {};
export default class App extends Component<Props> {
  constructor(props) {
    super(props)
    this.state = {color: '#ddd'}
  }

  render() {
    return (
      <View style={styles.container}>
        <MyView
            style={styles.myView}
            text='First'
            textColor={this.state.color}
            fontSize={24}
            onClickHandler={(event)=>{
              const { count } = event.nativeEvent;
              Alert.alert('Native Button Clicked', `点击次数:${count}`)
            }}
        />
        <MyView
            style={styles.myView}
            userInteractionEnabled={false}
            text='Second'
            textColor='#eee'
            fontSize={16}
        />
        <TouchableOpacity
            style={styles.button}
            onPress={()=>{
              const color = this.state.color === '#ddd' ? '#000' : '#ddd'
              this.setState({color})}}
        >
          <Text style={styles.text}>change text color</Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  myView: {
    backgroundColor: 'red',
    height: 100,
    width: 200,
    marginTop: 10,
  },
  button: {
    marginTop: 10,
    backgroundColor: 'blue',
    padding: 15,
  },
  text: {
    color: 'white',
    fontSize: 24,
    textAlign: 'center',
  }
});
