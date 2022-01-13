import React, { useState } from "react";
import { StyleSheet, Text, View, Image } from "react-native";
//import * as ScreenCapture from 'expo-screen-capture';

export default class screenshot extends React.Component {
    async componentDidMount() {
        await ScreenCapture.preventScreenCaptureAsync();
      }
    render(){
        return(
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'space-around' }}>
                <Text>screenshot</Text>
            </View>
        )
    }
}