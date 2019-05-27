/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {StyleSheet, View, Alert, TouchableOpacity, Text, TextInput, NativeModules, NativeEventEmitter} from 'react-native';
import MyView from './components/MyView'
type Props = {};
export default class App extends Component<Props> {
  constructor(props) {
    super(props)
    const userName = NativeModules.UserDefaults.userName
    this.state = {color: '#ddd', userName}
  }

  componentDidMount() {
    const { IOSEventEmitter } = NativeModules
    const nativeEventEmitter = new NativeEventEmitter(IOSEventEmitter);
    console.log(IOSEventEmitter, nativeEventEmitter);
    this.begin = nativeEventEmitter.addListener('begin_load_data', ()=>{
      Alert.alert('开始加载数据')
    })
    this.loading = nativeEventEmitter.addListener('loading_data', ()=>{
      Alert.alert('正在加载数据')
    })

    this.end = nativeEventEmitter.addListener('end_load_data', ()=>{
      Alert.alert('结束加载数据')
    })
    console.log(this.begin, this.loading, this.end)
    const userDefaults = NativeModules.UserDefaults
    userDefaults.queryUserNameForKey('userName',(error, userName)=>{
      if (error) {
        Alert.alert('获取用户名失败')
      } else {
        this.setState({userName})
      }
    })

    userDefaults.loadData().then(({data})=>{
      Alert.alert(`data:${data}`)
    }).catch(({code, message})=>{
      Alert.alert(`error:${message}, code:${code}`)
    })
  }

  componentWillUnmount(){
    this.begin.remove()
    this.loading.remove()
    this.end.remove()
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
        <TextInput
            style={styles.textInput}
            placeholder='input user name'
            returnKeyType='done'
            placeholderTextColor='#666'
            value={this.state.userName}
            onChangeText={text=>this.setState({userName: text})}
        />
        <View style={styles.buttonGroup}>
          <TouchableOpacity
              style={styles.button}
              onPress={()=>{
                const userDefaults = NativeModules.UserDefaults
                userDefaults.saveUserName(this.state.userName, 'userName')
              }}
          >
            <Text style={styles.text}>Save</Text>
          </TouchableOpacity>
          <TouchableOpacity
              style={styles.button}
              onPress={_=>{
                const userDefaults = NativeModules.UserDefaults
                const userName = userDefaults.getUserNameForKey('userName')
                this.setState({userName})
              }}
          >
            <Text style={styles.text}>Get</Text>
          </TouchableOpacity>
        </View>
        <TouchableOpacity
            style={styles.button}
            onPress={()=>{
              const eventEmitter = NativeModules.IOSEventEmitter;
              eventEmitter.sendEvents()
            }}
        >
          <Text style={styles.text}>send native event to RN</Text>
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
    marginStart: 10,
  },
  text: {
    color: 'white',
    fontSize: 24,
    textAlign: 'center',
  },
  textInput: {
    marginTop: 10,
    padding: 10,
    borderColor: '#555',
    borderWidth: StyleSheet.hairlineWidth,
    marginHorizontal: 10,
    borderRadius: 5,
  },
  buttonGroup: {
    flexDirection: 'row',
  },
});
