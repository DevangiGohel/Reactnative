import React, { useState } from "react";
import {
  StyleSheet,
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ToastAndroid,
} from "react-native";
import { Value } from "react-native-reanimated";
import auth from "@react-native-firebase/auth";
import firebase from "firebase";
import Spinner from "react-native-loading-spinner-overlay";

export default class register extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      Spinner: false,
      emailValidate: true,
      email: "",
      fNameValidate: true,
      fname: "",
      lNameValidate: true,
      lname: "",
      passwordValidate: true,
      password: "",
    };
  }
  validate_field = () => {
    const { fname, lname, email, password } = this.state;
    let reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w\w+)+$/;
    if (fname == "") {
      ToastAndroid.show("Please Enter First Name", ToastAndroid.SHORT);
      this.setState({ fNameValidate: false });
      return false;
    }
    if (lname == "") {
      ToastAndroid.show("Please Enter Last Name", ToastAndroid.SHORT);
      this.setState({ lNameValidate: false });
      return false;
    }
    if (reg.test(email) === false) {
      ToastAndroid.show("Please Enter Valid Email Address", ToastAndroid.SHORT);
      this.setState({ emailValidate: false });
      return false;
    }
    if (password == "") {
      ToastAndroid.show("Enter Valid Password", ToastAndroid.SHORT);
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
  making_reg_call = () => {
    if (this.validate_field()) {
      this.setState({ Spinner: true });
      try {
        firebase
          .auth()
          .createUserWithEmailAndPassword(this.state.email, this.state.password)
          .then((user) => {
            console.log(user);
            this.setState({ Spinner: false });
            ToastAndroid.show(
              "Registration success...Please login",
              ToastAndroid.SHORT
            );
            this.props.navigation.goBack();
          });
      } catch (error) {
        this.setState({ Spinner: false });
        ToastAndroid.show(error.toString(error), ToastAndroid.SHORT);
        console.log(error.toString(error));
      }
    }
  };
  render() {
    const { navigate } = this.props.navigation;

    return (
      <View style={styles.container}>
        <View>
          <Text style={styles.title}>Registration</Text>
          <View style={styles.inputStyles}>
            <TextInput
              style={[
                styles.username,
                !this.state.fNameValidate ? styles.error : null,
              ]}
              onChangeText={(Value) => this.setState({ fname: Value })}
              placeholder="FirstName"
            />

            <TextInput
              style={[
                styles.username,
                !this.state.lNameValidate ? styles.error : null,
              ]}
              onChangeText={(Value) => this.setState({ lname: Value })}
              placeholder="LastName"
            />

            <TextInput
              style={[
                styles.username,
                !this.state.emailValidate ? styles.error : null,
              ]}
              onChangeText={(Value) => this.setState({ email: Value })}
              placeholder="Email Address"
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
            <TouchableOpacity onPress={() => this.making_reg_call()}>
              <Text style={styles.buttonStyle}>Register</Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.login}
              onPress={() => this.props.navigation.goBack()}
            >
              <Text>Already a member? Login here...</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    );
  }
}

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
    height: "28%",
    fontSize: 20,
  },
  error: {
    borderBottomColor: "red",
    borderBottomWidth: 1,
  },
  login: {
    justifyContent: "center",
    alignItems: "center",
  },
});
