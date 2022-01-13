import React, { useState } from "react";
import {
  ActivityIndicator,
  StyleSheet,
  Text,
  View,
  Image,
  TextInput,
  TouchableOpacity,
  ToastAndroid,
} from "react-native";

import * as TaskManager from 'expo-task-manager';
import * as Location from 'expo-location';
import * as Permissions from 'expo-permissions';
import Geocoder from 'react-native-geocoding';

import firebase from "firebase";
import Spinner from "react-native-loading-spinner-overlay";
//import crashlytics from '@react-native-firebase/crashlytics';

const LOCATION_TASK_NAME = 'background-location-task';

export default class login extends React.Component {

  componentDidMount(){

    let { status } =  Permissions.askAsync(Permissions.LOCATION);

    if (status !== 'granted') {
    
        console.log('Permission to access location was denied');
      }
    Location.startLocationUpdatesAsync(LOCATION_TASK_NAME,{
      accuracy : Location.Accuracy.Balanced,
      timeInterval : 5000
    })

    
  }

  constructor(props) {
    super(props);
    this.state = {
      Spinner: false,
      usernameValidate: true,
      username: "",
      passwordValidate: true,
      password: "",
    };
  }
  validate_field = () => {
    const { username, password } = this.state;
    if (username == "") {
      ToastAndroid.show("Please Enter Username", ToastAndroid.SHORT);
      this.setState({ usernameValidate: false });
      return false;
    }
    if (password == "") {
      ToastAndroid.show("Please Enter Password", ToastAndroid.SHORT);
      this.setState({ passwordValidate: false });
      return false;
    }
    if (password.length < 6) {
      ToastAndroid.show("Enter Valid Password", ToastAndroid.SHORT);
      this.setState({ passwordValidate: false });
      return false;
    }
    return true;
  };
  making_login_call = () => {
    if (this.validate_field()) {
      this.setState({ Spinner: true });
      try {
        firebase
          .auth()
          .signInWithEmailAndPassword(this.state.username, this.state.password)
          .then((res) => {
            console.log(res.user.email);
            this.setState({ Spinner: false });
            this.props.navigation.navigate("dashboard");
          });
      } catch (error) {
        console.warn(error.toString(error));
        this.setState({ Spinner: false });
        ToastAndroid.show(error.toString(error), ToastAndroid.SHORT);
      }
    }
  };

  onPress = async () => {
    await Location.startLocationUpdatesAsync(LOCATION_TASK_NAME, {
      accuracy: Location.Accuracy.Balanced,
      timeInterval: 5000,
    });
  };
  
  render() {
    const { navigate } = this.props.navigation;
    return (
      <View style={styles.container}>
        <Spinner visible={this.state.Spinner} color="#696969"></Spinner>
        <View>
          <Text style={styles.title}>Login</Text>
          <View style={styles.inputStyles}>
            <TextInput
              style={[
                styles.username,
                !this.state.usernameValidate ? styles.error : null,
              ]}
              onChangeText={(Value) => this.setState({ username: Value })}
              placeholder="Username"
            />
            <TextInput
              style={[
                styles.username,
                !this.state.passwordValidate ? styles.error : null,
              ]}
              placeholder="Password"
              secureTextEntry
              onChangeText={(Value) => this.setState({ password: Value })}
            />
            <TouchableOpacity onPress={()=>this.making_login_call()}>
              <Text style={styles.buttonStyle}>Login</Text>
            </TouchableOpacity>

            <TouchableOpacity >
              <Text style={styles.buttonStyle}>Crash</Text>
            </TouchableOpacity>

            <TouchableOpacity
              style={styles.register}
              onPress={() => this.props.navigation.navigate("register")}
            >
              <Text>Not a member? Register here...</Text>
            </TouchableOpacity>

          </View>
        </View>
      </View>
    );
  }

 
}

TaskManager.defineTask(LOCATION_TASK_NAME, ({ data, error }) => {
  if (error) {
    alert(error)
    console.log(error);
    return;
  }
  if (data) {
    const { locations } = data; 
    console.log(locations[0].coords.latitude);
    console.log(locations[0].coords.longitude);
  }
})

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  title: {
    width: "100%",
    padding: 5,
    marginTop: 40,
    fontSize: 30,
    textAlign: "center",
    color: "#696969",
  },
  inputStyles: {
    marginTop: 60,
  },
  username: {
    width: "90%",
    padding: 5,
    margin: 10,
    borderRadius: 10,
    borderBottomColor: "#808080",
    borderBottomWidth: 1,
  },
  buttonStyle: {
    textAlign: "center",
    alignSelf: "center",
    marginTop: 20,
    padding: 3,
    backgroundColor: "#696969",
    color: "#ffff",
    borderRadius: 10,
    width: "90%",
    height: "25%",
    fontSize: 20,
  },
  error: {
    borderBottomColor: "red",
    borderBottomWidth: 1,
  },
  register: {
    justifyContent: "center",
    alignItems: "center",
  },
});